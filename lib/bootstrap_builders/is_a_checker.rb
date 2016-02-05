class BootstrapBuilders::IsAChecker
  def self.is_a?(object, class_name)
    BootstrapBuilders::IsAChecker.new(object: object, class_name: class_name).is_a?
  end

  def initialize(args)
    @object = args.fetch(:object)
    @class_name = args.fetch(:class_name).to_s
  end

  def is_a?
    @object.class.ancestors.map(&:name).include?(@class_name)
  end
end
