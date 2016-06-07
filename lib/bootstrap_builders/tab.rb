class BootstrapBuilders::Tab
  attr_accessor :container_html
  attr_reader :container_id, :label

  def initialize(args)
    @active = args[:active]
    @label = args.fetch(:label)

    @container_id = args[:container_id].presence
    @container_id ||= SecureRandom.hex
  end

  def active?
    @active
  end
end
