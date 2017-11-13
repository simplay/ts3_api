module TS3API
  class ClientList
    include Command

    def instruction
      "clientlist"
    end

    def arguments
      %w(
        -uid 
        -away 
        -voice 
        -times 
        -groups 
        -info 
        -icon 
        -country
      ).join(' ')
    end
  end
end
