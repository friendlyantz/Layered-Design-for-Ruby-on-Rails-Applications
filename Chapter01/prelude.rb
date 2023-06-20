# frozen_string_literal: true

require_relative "../lib/helpers"

using ChapterHelpers

# Add gems
gems do
  gem "trace_location", "0.12.1", github: "palkan/trace_location", ref: "1c222dd8576e9e2d2ee12100037ef951e70c0353"
end

require_relative "../lib/boot"

# Configure output folder for trace_location
require "trace_location"
TraceLocation.configure do |config|
  config.dest_dir = File.join(__dir__, "../log")
end
