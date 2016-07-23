class BootstrapBuilders::ArgumentsParser
  attr_reader :arguments, :arguments_hash

  def initialize(args)
    @arguments = args.fetch(:arguments)

    if args[:argument_hash_default]
      @arguments_hash = args.fetch(:argument_hash_default)
    else
      @arguments_hash = {}
    end

    if @arguments.last.is_a?(Hash)
      @arguments_hash = @arguments_hash.merge(@arguments.pop)
    end

    @arguments << @arguments_hash

    @short_true_arguments = args[:short_true_arguments]
    parse_short_true_arguments if @short_true_arguments
  end

private

  def parse_short_true_arguments
    @arguments.delete_if do |argument|
      if @short_true_arguments.include?(argument)
        @arguments_hash[argument] = true
        true
      else
        false
      end
    end
  end
end
