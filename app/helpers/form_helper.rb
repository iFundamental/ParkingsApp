module FormHelper

def setup_parking(parking)
    parking.address ||= Address.new
    parking
  end
end
