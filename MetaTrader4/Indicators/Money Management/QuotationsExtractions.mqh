/*
    Quotations Extraction
*/
/* 
    Expert Advisor to send quotes (Open / Close / high / Low) every minute, from multiple symbols(), to a database.
    for example:
        Defining the symbol(): EUR/USD, USD/JPY
        Defining the start time to start sending the information to the database for example starts at 7 am.
        Defining the finish time to stop the information to be sent, or when i turn off the expert advisor.

    ACCESS MYSQL DABATASE
    https://www.mql5.com/pt/articles/932
 */

#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property strict

// creating object type
enum onoff { 
    on = 1, // ON
    off = 0 // OFF
    };

input onoff start = on; // Expert Advisor active:
input int TimeStart = 7; // Insert the Start Time from 1 to 24.
input int TimeFinish = 7; // Insert the Start Time from 1 to 24.
input string Host = 'host'; // MYSQL Host, ex: 127.0.0.1
input string User = 'User'; // MYSQL User, ex: admin
input string Password = 'password'; // MYSQL Password, ex: adminpass
input string Database = 'database_name'; // MYSQL Database Name, ex: candles_db
input string Port = 'port'; // MYSQL Port, ex: 3060
input string Socket = 'socket'; // MYSQL Socket, ex: 101012

int ClientFlag = CLIENT_MULTI_STATEMENTS; // Definir o flag multi-statements
string Host, User, Password, Database, Socket; // database credentials
int Port;
int DB; // database identifier

int OnInit(){
    // reading database credentials - Credentials defined by the user
    DB = MySqlConnect(Host, User, Password, Database, Port, Socket, ClientFlag); // Conection to data base
    EventSetTimer(60);
    return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
    EventKillTimer();
}

void OnTick() {
}

void OnTimer() {
    if(start == on && TimeHour(Time[0]) => TimeStart && TimeHour(Time[0]) =< TimeFinish){
       double candle =  getQuotes();
        /* CONNECT TO MYSQL */
    if (DB == -1) { 
     Print ("Connection failed! Error: "+MySqlErrorDescription); 
    } else {
     string Query;
     // Inserting data 1 row
     Query = "INSERT INTO `Candles` (currency, open, close, maximum, minimum) VALUES ("+Symbol()+","+candle.O+","+candle.C+","+candle.H+","+candle.L+")";
     if (MySqlExecute(DB, Query))
        {
         Print ("Succeeded: ", Query);
        }
     else
        {
         Print ("Error: ", MySqlErrorDescription);
         Print ("Query: ", Query);
        }
    }
    }  
}


//function to get the quotes and save it to the database
void getQuotes() {
    double O = 0.0;
    double C = 0.0;
    double H = 0.0;
    double L = 0.0;

    O = Open[0];
    C = Close[0];
    H = High[0];
    L = Low[0];
    double candle = [O, C, H, L];
    return candle;
}