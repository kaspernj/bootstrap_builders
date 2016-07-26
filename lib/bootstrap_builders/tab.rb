class BootstrapBuilders::Tab
  attr_accessor :active, :container_html
  attr_reader :ajax_url, :container_id, :label

  def initialize(args)
    @active = args[:active]
    @label = args.fetch(:label)
    @ajax_url = args[:ajax_url]

    @container_id = args[:container_id].presence
    @container_id ||= SecureRandom.hex
  end

  def active?
    @active
  end
end
