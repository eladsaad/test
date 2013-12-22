json.array!(@operation_operator_mobile_stations) do |operation_operator_mobile_station|
  json.extract! operation_operator_mobile_station, :id, :code
  json.url operation_operator_mobile_station_url(operation_operator_mobile_station, format: :json)
end
