class WebsocketController < WebsocketRails::BaseController

  def coordinates
    p "----------- MESSAGE ------------"
    p message
    coordinates = geong.coordinates(message["query"])
    p "----------- RESULT ------------"
    result = {
      id: message["id"],
      longitude: coordinates.longitude,
      latitude: coordinates.latitude
    }
    p result
    send_message(:coordinates, result)
  end

  private
  def geong
    Thread.current[:geong_client] ||= Geong::Client.new(host: "127.0.0.1").tap(&:open)
  end
end
