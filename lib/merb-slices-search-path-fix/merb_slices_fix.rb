module Merb
  module Slices
    class << self
      #
      # Look for any slices in those default locations or if given, 
      # Merb::Plugins.config[:merb_slices][:search_path] (String/Array).
      # Specify files, glob patterns or paths containing slices.
      def slice_files_from_search_path
        search_paths = Array(Merb::Plugins.config[:merb_slices][:search_path] ||
          [Merb.root / "slices"])
        search_paths.inject([]) do |files, path|
          # handle both Pathname and String
          path = path.to_s
          if File.file?(path) && File.extname(path) == ".rb"
            files << path
          elsif path.include?("*")
            files += glob_search_path(path)
          elsif File.directory?(path)
            # Dir.glob("**/lib/*.rb") can't glob beyond symbolic links
            files += glob_search_path(path / "*/lib/*.rb")
          end
          files
        end
      end
    end
  end
end
