#!/bin/env ruby
# encoding: utf-8

require "meme"
require "tinyurl"

class MemeController < Rubot::Controller
  command :awyeah do
    reply "http://bit.ly/gJJ2sb"
  end

  command :trollface do
    reply "http://bit.ly/8dhBaI"
  end

  command :idunnolol do
    reply "¯\\(°_o)/¯"
  end

  command :meme do
    begin
      if message.text =~ /--list/
        reply Meme::GENERATORS.map(&:first).join(", ")
      else
        args = Shellwords.shellsplit(message.text)
        meme = Meme.new(args.shift)
        reply Tinyurl.new(meme.generate(*args)).tiny
      end
    rescue Exception => e
      reply e.message
    end
  end
end