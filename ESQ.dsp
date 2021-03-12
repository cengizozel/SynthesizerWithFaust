import("stdfaust.lib");

gain = hslider("v:Synth/v:[1]Edit/[0]Volume", 0.2, 0, 1, 0.01);
freq = hslider("v:Synth/v:[1]Edit/[1]Frequency", 262, 50, 1000, 0.1);
pw = hslider("v:Synth/v:[1]Edit/[2]PW", 0.5, 0, 1, 0.001);
cutoff = hslider("v:Synth/v:[1]Edit/[3]Cutoff",10000,50,10000,0.01);
Q = hslider("v:Synth/v:[1]Edit/[4]Q",1,1,30,0.1);

saw = os.lf_saw(freq);
square = os.pulsetrain(freq, pw);

sawCB = checkbox("v:Synth/h:[0]Waveform/[0]Saw")*saw;
squareCB = checkbox("v:Synth/h:[0]Waveform/[1]Square")*square;

cutoffEffect = fi.resonlp(cutoff,Q,gain);

process = sawCB, squareCB :> _,gain : * <: 
attach(_,abs : ba.linear2db : hbargraph("v:Synth/v:[1]Edit/[5]Level",-60,0)) : 
cutoffEffect <: _,_;
