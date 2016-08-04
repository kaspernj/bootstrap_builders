class BootstrapBuilders::Tab
  attr_accessor :active, :container_html
  attr_reader :ajax_url, :container_id, :label

  def initialize(args)
    @active = args[:active]
    @label = args.fetch(:label)
    @ajax_url = args[:ajax_url]

    if args[:container_id]
      @specific_id_given = true
    else
      @specific_id_given = false
    end

    @container_id = args[:container_id].presence
    @container_id ||= SecureRandom.hex
  end

  def active?
    @active
  end

  def specific_id_given?
    @specific_id_given
  end
end
