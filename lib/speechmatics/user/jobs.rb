# -*- encoding: utf-8 -*-

require 'mimemagic'

module Speechmatics
  class User::Jobs < API
    include Configuration

    def create(params={})
      attach_audio(params)
      set_mode(params)
      super
    end

    def transcript(params={})
      self.current_options = current_options.merge(args_to_options(params))
      request(:get, "#{base_path}/transcript")
    end

    def audio(params={})
      self.current_options = current_options.merge(args_to_options(params))
      request(:get, "#{base_path}/audio")
    end

    def set_mode(params={})
      params[:model] ||= 'en-US'
      params
    end

    def attach_audio(params={})
      file_path = params[:data_file]
      raise "No file specified for new job, please provide a :data_file value" unless file_path
      raise "No file exists at path '#{file_path}'" unless File.exists?(file_path)

      content_type = params[:content_type] || MimeMagic.by_path(file_path).to_s
      raise "No content type specified for file, please provide a :content_type value" unless content_type
      raise "Content type for file '#{file_path}' is not audio, it is '#{content_type}'." unless (content_type =~ /audio/)

      params[:data_file] = Faraday::UploadIO.new(file_path, content_type)
      params
    end

  end
end
