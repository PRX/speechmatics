# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe Speechmatics::Client do

  let(:new_job) {
    {
      balance: 90,
      cost: 0.50,
      id: 2
    }
  }

  let(:list_jobs) {
    {
      "jobs" => [
        {
          "created_at" => "Wed, 04 Dec 2013 16:00:47 GMT",
          "duration" => 244,
          "id" => 2,
          "lang" => "en-US",
          "name" => "test.mp3",
          "next_check" => 0,
          "notification" => "email",
          "size" => 1955132,
          "transcription" => "test.json",
          "job_status" => "done"
        },
        {
          "created_at" => "Wed, 04 Dec 2013 16:08:33 GMT",
          "duration" => 244,
          "id" => 12,
          "lang" => "en-GB",
          "name" => "second-test.mp3",
          "next_check" => 1389966796,
          "notification" => "email",
          "size" => 6475938,
          "transcription" => nil,
          "job_status" => "transcribing"
        }
      ]
    }
  }

  let(:transcript) {
    {
      "speakers" => [
      {
        "duration" => "1.270",
        "name" => "M1",
        "time" => "0.590"
      }
      ],
      "words" => [
      {
        "duration" => "0.230",
        "name" => "Hello",
        "time" => "0.590"
      },
      {
        "duration" => "0.070",
        "name" => "World",
        "time" => "0.960"
      },
      {
        "duration" => "0.000",
        "name" => ".",
        "time" => "1.270"
      }
      ]
    }
  }

  let(:alignment) {
    "[00:00:00.1]	Hello world how are you?"
  }

  let(:stubs) {
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/v1.0/user/1/jobs/?auth_token=token') { [200, {"Content-Type" => "application/json"}, list_jobs.to_json] }
      stub.post('/v1.0/user/1/jobs/?auth_token=token') { [200, {"Content-Type" => "application/json"}, new_job.to_json] }
      stub.get('/v1.0/user/1/jobs/1/transcript?format=txt&auth_token=token') { [200, {"Content-Type" => "text/plain"}, "Hello World."] }
      stub.get('/v1.0/user/1/jobs/1/transcript?auth_token=token') { [200, {"Content-Type" => "application/json"}, transcript.to_json] }
      stub.get('/v1.0/user/1/jobs/1/alignment?auth_token=token') { [200, {"Content-Type" => "text/plain"}, alignment] }
    end
  }

  let(:jobs) {
    Speechmatics::User::Jobs.new(
      user_id: 1,
      auth_token: 'token',
      adapter: [:test, stubs])
  }

  it "lists jobs" do
    jl = jobs.list
    jl.objects.count.must_equal 2
    jl.jobs.count.must_equal 2
  end

  it "creates job for an audio file" do
    r = jobs.create(data_file: File.expand_path(File.dirname(__FILE__) + '/../zero.wav'))
    r.id.must_equal 2
    r.cost.must_equal 0.50
    r.balance.must_equal 90
  end

  it "creates job for a video file" do
    r = jobs.create(data_file: File.expand_path(File.dirname(__FILE__) + '/../zero.mp4'))
    r.id.must_equal 2
    r.cost.must_equal 0.50
    r.balance.must_equal 90
  end

  it "gets transcript" do
    t = jobs.transcript(job_id: 1)
    t.speakers.count.must_equal 1
    t.words.count.must_equal 3
  end

  it "gets transcript as text" do
    t = jobs.transcript(job_id: 1, format: "txt")
    t.object.must_equal "Hello World."
  end

  it "can align a text representation of the audio" do
    a = jobs.alignment(job_id: 1)
    a.object.must_equal alignment
  end

  it "can fetch txt transcription after fetching full" do
    t1 = jobs.transcript(job_id: 1)
    t1.speakers.count.must_equal 1
    t1.words.count.must_equal 3

    t2 = jobs.transcript(job_id: 1, format: "txt")
    t2.object.must_equal "Hello World."
  end

  it "can fetch alignment after fetching transcription" do
    t = jobs.transcript(job_id: 1)
    t.speakers.count.must_equal 1
    t.words.count.must_equal 3

    a = jobs.alignment(job_id: 1)
    a.object.must_equal alignment
  end
end
