class Scheduler
  def call
    start_time = -15

    Show.need_be_update.map do |show|
      remote_show = remote_shows.find { |rs| rs['id'] == show.id }

      next if remote_show['quantity'] == show.quantity

      { show.id => start_time+= 15 }
    end.compact
  end

  def remote_shows
    @remote_shows ||= JSON.parse show_api_request.body
  rescue StandardError => _e
    []
  end

  def show_api_request
    @show_api_request ||= Faraday.get('https://shows-remote-api.com')
  end
end
