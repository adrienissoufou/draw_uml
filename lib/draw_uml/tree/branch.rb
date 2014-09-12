module DrawUml
  module Tree
    class Branch < DrawUml::Tree::Leaf
      attr_reader :entries

      def initialize(name, level=0)
        @entries = []
        super
        node
      end

      def leaf?
        false
      end

      def each(&block)
        entries.each do |entry|
          block.call(entry)
          entry.each(&block) if entry.is_a?(DrawUml::Tree::Branch)
        end
      end

      private
        def node
          Dir[File.join(path, '*')].each do |path|
            if File.directory?(path)
              entries << DrawUml::Tree::Branch.new(path, level+1)
            else
              entries << DrawUml::Tree::Leaf.new(path, level+1)
            end
          end
        end
      # end private
    end
  end
end
