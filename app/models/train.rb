class Train < ApplicationRecord

  def self.find_by_code(symbol)
    # Train.where(symbol: symbol)
    Train.where("symbol LIKE ?", "%#{symbol}%")
  end

end
