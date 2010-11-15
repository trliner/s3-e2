require 'rubygems'
require 'rspec'
require File.join(File.dirname(__FILE__) + '/../../lib/pressman')

describe Board do

  before do
    @board = Board.new
  end

  it "has eight columns" do
    @board.columns.count.should == 8
  end

  it "has eight rows" do
    @board.rows.count.should == 8
  end

  it "has a number of black stones" do
    @board.stones[:black].should > 0
  end

  it "has a number of white stones" do
    @board.stones[:white].should > 0
  end
end