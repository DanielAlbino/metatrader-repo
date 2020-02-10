/*
    Quotations Extraction
*/
/* 
    Gostaria de um app que enviasse as cotações (a/f/mx/mn) de cada minuto (eu irei selecionar o período) para vários ativos (que eu irei selecionar) simultaneamente para um banco de dados.
    Por exemplo: 
        Defino os ativos EUR/USD; EUR/JPY, USD/JPY
        Imaginemos que agora são 10:00 (GMT -3) - Horário Brasilia
        Defino que quero receber as informações a partir as 7:00 em diante e continue até eu desativar/desligar o app

    ACCESS MYSQL DABATASE
    https://www.mql5.com/pt/articles/932
 */

#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property strict

input int TimeStart = 7; // Insert the Start Time
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
    getQuotes();
}

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

/* CONNECT TO MYSQL */
    if (DB == -1) { 
     Print ("Connection failed! Error: "+MySqlErrorDescription); 
    } else {
     string Query;
     // Inserting data 1 row
     Query = "INSERT INTO `Candles` (currency, open, close, maximum, minimum) VALUES ("+Symbol()+","+O+","+C+","+H+","+L+")";
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
    return candle;
}