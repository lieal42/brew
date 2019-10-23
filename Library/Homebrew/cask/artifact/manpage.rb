# frozen_string_literal: true

require "cask/artifact/symlinked"

module Cask
  module Artifact
    class Manpage < Symlinked
      attr_reader :section

      def self.from_args(cask, source)
        section = source.to_s[/\.([1-8]|n|l)$/, 1]

        raise CaskInvalidError, "'#{source}' is not a valid man page name" unless section

        new(cask, source, section)
      end

      def initialize(cask, source, section)
        @section = section

        super(cask, source)
      end

      def resolve_target(_target)
        config.manpagedir.join("man#{section}", target_name)
      end

      def target_name
        "#{@source.basename(@source.extname)}.#{section}"
      end
    end
  end
end
