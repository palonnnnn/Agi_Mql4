//+------------------------------------------------------------------+
//|                                                     ButtonEA.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   CreasteButton();
   ChkAutoTrading();
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
      ObjectsDeleteAll();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  
        CreasteButton();
        ChkAutoTrading();
   
   
  }
  
 void OnChartEvent(const int id,const long& lparam,const double& dparam,const string& sparam)
        {
         if(id == CHARTEVENT_OBJECT_CLICK && sparam == "btn1" )
           {
               OpenBuy();
           }
           else if(id == CHARTEVENT_OBJECT_CLICK && sparam == "closebuy")
            {
               ClosOrder();
            }
        }
 
void OpenBuy(){
      
      int ticketbuy = OrderSend(Symbol(),OP_BUY,0.01,Ask,3,0,0,"",0,0,Blue);
      
}
void ClosOrder(){
      for(int i= OrdersTotal()-1;i>=0;i--)
        {
         if(OrderSelect(i,SELECT_BY_POS)==true)
           {
            if((OrderMagicNumber() == 0 ) && OrderSymbol() == Symbol())
              
                  if(OrderType() == OP_BUY)
                    
                     if(OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),0,0))Print("");
                      
                    
              
           }
        }

}

bool state = false;

void ChkAutoTrading(){
   
   if(IsExpertEnabled()){
         ObjectSetInteger(0,"btn1",OBJPROP_BGCOLOR,clrGreen);
         ObjectSetString(0,"btn1",OBJPROP_TEXT,"Order Sell");
   }else {
         state = !state;
         ObjectSetInteger(0,"btn1",OBJPROP_BGCOLOR,clrRed);
         ObjectSetString(0,"btn1",OBJPROP_TEXT,"Off Sell");
         ObjectSetInteger(0,"btn1",OBJPROP_STATE,state);
   }
   
}
void CreasteButton(){

   ObjectCreate(0,"btn1",OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,"btn1",OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ObjectSetInteger(0,"btn1",OBJPROP_XDISTANCE,10);
   ObjectSetInteger(0,"btn1",OBJPROP_YDISTANCE,50);
   ObjectSetInteger(0,"btn1",OBJPROP_XSIZE,100);
   ObjectSetInteger(0,"btn1",OBJPROP_YSIZE,50);
   ObjectSetInteger(0,"btn1",OBJPROP_FONTSIZE,15);
   ObjectSetInteger(0,"btn1",OBJPROP_COLOR,clrWhite);
   
   ObjectCreate(0,"closebuy",OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,"closebuy",OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ObjectSetInteger(0,"closebuy",OBJPROP_XDISTANCE,120);
   ObjectSetInteger(0,"closebuy",OBJPROP_YDISTANCE,50);
   ObjectSetInteger(0,"closebuy",OBJPROP_XSIZE,100);
   ObjectSetInteger(0,"closebuy",OBJPROP_YSIZE,50);
   ObjectSetInteger(0,"closebuy",OBJPROP_FONTSIZE,15);
   ObjectSetInteger(0,"closebuy",OBJPROP_COLOR,clrWhite);
   ObjectSetString(0,"closebuy",OBJPROP_TEXT,"Close Buy");
   ObjectSetInteger(0,"closebuy",OBJPROP_BGCOLOR,clrGreen);
   
}