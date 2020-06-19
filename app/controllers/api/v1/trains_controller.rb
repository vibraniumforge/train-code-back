module Api::V1
  class TrainsController < ApplicationController

    def show
      @train = Train.find(params[:id])
      render json: @train
    end

    def get_train_by_symbol
      @train = Train.find_by_code(params[:symbol])
      puts "train = #{@train.pluck(:id)}"
      if @train.length > 0
        render json: {data: @train, success: true, message: "OK"}
      else
        render json: { success: false, message: "No trains found"}
      end
    end

  end
end