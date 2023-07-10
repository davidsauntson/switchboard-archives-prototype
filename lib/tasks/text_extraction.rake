# frozen_string_literal: true

require_relative '../../services/contentful/entry_service'
require_relative '../../services/contentful/managed_entry_service'
require 'httparty'
require 'pry'

task text_extraction: :environment do
  # save text
  # save overlay info
  # save pdf

  text_content_types = %w[document printedMedia]

  entries = []
  text_content_types.map do |content_type|
    result = Contentful::EntryService.new.fetch_all(content_type)
    entries += result.items
  end

  entries.each do |entry|
    next unless entry.try(:scan_urls)

    # skip empty scan urls
    next if entry.scan_urls.blank?

    parsed_text = ''

    entry.scan_urls.each do |scan_url|
      body = {
        url: scan_url,
        language: 'eng',
        isOverlayRequired: true,
        isCreateSearchablePdf: false,
        detectOrientation: true,
        filetype: 'JPG'
      }

      # call OCR API
      response = HTTParty.post(
        'https://api.ocr.space/parse/image',
        body: body,
        multipart: true,
        headers: {
          "Content-Type": 'application/json',
          apikey: ENV['OCR_API_KEY']
        }
      )

      if response['IsErroredOnProcessing']
        puts "error in entry #{entry.id}"
        next
      end

      parsed_text = "#{parsed_text}\r\n#{response.dig('ParsedResults', 0, 'ParsedText')}"
    end

    managed_entry = Contentful::ManagedEntryService.new.fetch(entry.id)

    begin
      managed_entry.text = parsed_text
      managed_entry.publish
      puts "updated text for entry #{entry.title}"
    rescue StandardError
      puts "error on saving  entry #{entry.id}"
    end
  end
end
