require "spec_helper"

describe PointTransaction do
  describe "validations" do
    it "should require a sender" do
      transaction = PointTransaction.new
      transaction.validate
      transaction.errors.should include(:sender)
    end
  
    it "should require a receiver" do
      transaction = PointTransaction.new
      transaction.validate
      transaction.errors.should include(:receiver)
    end
  
    it "should require an amount" do
      transaction = PointTransaction.new
      transaction.validate
      transaction.errors.should include(:amount)
    end

    it "should not require a sender when it is a generated transaction" do
      transaction = PointTransaction.new :generated => true
      transaction.validate
      transaction.errors.should_not include(:sender)
    end
  end

  describe "transactions" do
    it "should alter the receiver's score by the given amount" do
      sender = User.create :nick => "sender1"
      receiver = User.create :nick => "receiver1"
      transaction = PointTransaction.create :amount => 10, :sender => sender, :receiver => receiver
      receiver.score.should eql(10)
    end

    it "should charge the sender a fee of the abd of the amount" do
      sender = User.create :nick => "sender2"
      receiver = User.create :nick => "receiver2"
      transaction = PointTransaction.create :amount => 10, :sender => sender, :receiver => receiver
      sender.score.should eql(-10)
    end

    it "should not charge the sender a fee when the transaction is generated" do
      sender = User.create :nick => "sender3"
      receiver = User.create :nick => "receiver3"
      transaction = PointTransaction.create :amount => 10, :sender => sender, :receiver => receiver, :generated => true
      sender.score.should eql(0)
    end
  end
end