import FungibleToken from 0x69d75c78df55b148
import FlowToken from 0x69d75c78df55b148

pub contract Trust: FlowToken {

  pub nextChildID: UInt64
  pub trustData: {UInt64:Child}
  //pub amountData: {Address:UInt64}
  //pub maturities: {Address:UInt64}

  pub struct Child {
    pub childID: UInt64
    pub amonut: UInt64
    //pub maturity: UInt64
    pub paid: Bool

    init(amonut:UInt64,paid:Bool) {
      self.childID = Trust.nextChildID
      self.amonut = amonut
      //self.maturity = maturity
      self.paid = paid
      Trust.nextChildID = Trust.nextChildID + 1 as UInt64
    }
  }

  pub resource Fund {

    pub var balance: UFix64
        init(balance: UFix64) {
            self.balance = balance
        }
  }

  pub resource Admin {
    pub fun addChild(amount:UInt64, paid:Bool): UInt64{
      var newChild = Trust(amount:amount, paid:paid)
      let newID = newChild.childID
      Trust.trustData[newID] = newChild
      return newID
    }
  }

  init  {
    self.nextChildID = 0
  }
}