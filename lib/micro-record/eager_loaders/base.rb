module MicroRecord
  module EagerLoaders
    #
    # Base class for eagoer loading an association.
    #
    class Base
      # @return [String] association name
      attr_reader :name
      # @return [Proc] optional Proc for eager loading things on this association
      attr_reader :eval_block

      #
      # @param ref [ActiveRecord::Association] the ActiveRecord association
      # @param scope [Proc] a scope to apply to the query (optional)
      # @param eval_block [Proc] a block where you may perform eager loading on *this* association (optional)
      #
      def initialize(ref, scope = nil, &eval_block)
        @ref, @name, @model, @eval_block = ref, ref.name.to_s, ref.klass, eval_block
        @scope = scope ? scope.(ref.klass.all) : ref.klass.all
        @assign = "#{@name}="
      end

      #
      # Return the SQL to load the association.
      #
      # @param rows [Array] Array of rows
      #
      def query(rows)
        raise 'Not Implemented'
      end

      def merge!(assoc_rows, rows)
        raise 'Not Implemented'
      end
    end
  end
end
