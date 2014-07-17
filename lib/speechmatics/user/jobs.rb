# -*- encoding: utf-8 -*-

require 'filemagic'

module Speechmatics
  class User::Jobs < API
    include Configuration


    def create(params={})
      attach_audio(params)
      super
    end

    def attach_audio(params)
      file_path = params[:data_file]

      raise "No file specified for new job, please provide a :data_file value" unless file_path
      raise "No file exists at path '#{file_path}'" unless File.exists?(file_path)

      content_type = FileMagic.mime.file(file_path)
      params[:data_file] = Faraday::UploadIO.new(file_path, content_type)
    end

  end
end
