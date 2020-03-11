#property copyright "Copyright 2019, Daniel Albino"
#property link      ""
#property strict

double ordem;

void TrailingAlls(int magic, int trail)
  {
         double PointValue;
         for (int i = 0; i < OrdersTotal(); i++)
         {
            ordem = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
            PointValue = MarketInfo(OrderSymbol(), MODE_POINT);
            //Normalize trailing stop value to the point value
            double TSTP = trail * PointValue;
            if (OrderType() == OP_BUY && OrderMagicNumber() == magic)
               { if ((Bid - OrderOpenPrice()) > TSTP)
                  { if (OrderStopLoss() < (Bid - TSTP))
                     {
                         //modify trailing stop
                        ordem = OrderModify(OrderTicket(), OrderOpenPrice(), Bid - TSTP, OrderTakeProfit(), Red);
                     }
                  }
               }
			
			if (OrderType() == OP_SELL && OrderMagicNumber() == magic)
               { if ((OrderOpenPrice() - Ask) > trail * PointValue)
                  { if ((OrderStopLoss() > (Ask + trail * PointValue)) || (OrderStopLoss() == 0))
                     {
                        ordem = OrderModify(OrderTicket(), OrderOpenPrice(), Ask + TSTP, OrderTakeProfit(), Red);
                     }
                  }
               }
         }
}