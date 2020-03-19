// parametros do indicador

//---- indicator parameters
extern int ExtDepth=12;
extern int ExtDeviation=1;
extern int ExtBackstep=1;




// ----- variaveis --
double HighBuffer[];
double LowBuffer[];
int BarLimit = Bars;
int shift = 0;

double lastLow = 0, lasHigh = 0;

void createBuffer(){
    //---- drawing settings
    SetIndexStyle(0,DRAW_SECTION);

    //Buffer mapping 
    SetIndexBuffer(0,HighBuffer);
    SetIndexBuffer(1,LowBuffer);
    SetIndexEmptyValue(0,0.0);
}


void Verificaparametros(){
    double val
    for(shift=limit; shift>0; shift--){
        val = Low[iLowest(Symbol(),0,MODE_LOW,ExtDepth,shift)];
        if(val == lastLow) val = 0.0;
        else{
            lastLow = val;
        }
    }
}