class BootstrapBuilders::ArgumentsParser
  attr_reader :arguments

  def initialize(args)
    @arguments = args.fetch(:arguments)

    if args[:argument_hash_default]
      @argument_hash = args.fetch(:argument_hash_default)
    else
      @argument_hash = {}
    end

    if @arguments.last.is_a?(Hash)
      @argument_hash = @argument_hash.merge(@arguments.pop)
    end

    @arguments << @argument_hash

    @short_true_arguments = args[:short_true_arguments]
    parse_short_true_arguments if @short_true_arguments
  end

private

  def parse_short_true_arguments
    @arguments.delete_if do |argument|
      if @short_true_arguments.include?(argument)
        @argument_hash[argument] = true
        true
      else
        false
      end
    end
  end
end
