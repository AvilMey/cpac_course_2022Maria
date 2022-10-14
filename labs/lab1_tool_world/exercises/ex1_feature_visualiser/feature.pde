import ddf.minim.*;
import ddf.minim.analysis.*;


float compute_flatness(){
  float X_k;
  return random(3);
}

float compute_centroid(FFT fft, float[] freqs, int K){
  float numerator = 0;
  float denominator = 0;
  float centroid = 0;
  
  for ( int k=0; k<K; k++){
    numerator += freqs[k] * fft.getBand(k);
    denominator += fft.getBand(k);
  }

  
  centroid = numerator/(0.000001 + denominator); //para que no se divida directamente por 0 y de infinito
   
    return centroid;
}
  
float compute_spread(){
  float X_k;
  return random(3);
}

float compute_skewness(){
  float X_k;
  return random(3);  
}

float compute_entropy(){
  float X_k;
  return random(3);
}

float compute_energy(FFT fft, int K) {  //para calcular la energia usamos la fft y la K, siendo K el numero de bandas de la fft
  float energy=0; // cuando empezamos la energia es 0 y hay que ir añadiendo todos los componentes
  float X_k;
  for ( int k=0; k<K; k++){
    X_k = fft.getBand(k); //vamos cogiendo la fft de cada bin, hasta el ultimo. La K es bin
    //getBand() returns the amplitude of the requested frequency band
    energy = energy + X_k * X_k; //acumulamos la energia, asi la vamos sumando a la anterior
  }
  return energy;
}
class AgentFeature { 
  float sampleRate;
  int K;
  FFT fft;
  BeatDetect beat;
  
  float[] freqs;
  float sum_of_bands;
  float centroid;
  float spread;
  float energy;
  float skewness;
  float entropy;
  float flatness;
  boolean isBeat;
  float lambda_smooth;
  AgentFeature(int bufferSize, float sampleRate){    
    this.fft = new FFT(bufferSize, sampleRate);
    this.fft.window(FFT.HAMMING);
    this.K=this.fft.specSize(); //specSize() returns the number of frequency bands produced by this transform
    this.beat = new BeatDetect();
    
    this.lambda_smooth = 0.1;
    this.freqs=new float[this.K];
    for(int k=0; k<this.K; k++){
      this.freqs[k]= (0.5*k/this.K)*sampleRate;
    }
    
    this.isBeat=false;
    this.centroid=0;
    this.spread=0;
    this.sum_of_bands = 0;
    this.skewness=0;    
    this.entropy=0;
    this.energy=0;
  }
  float smooth_filter(float old_value, float new_value){
    /* Try to implement a smoothing filter using this.lambda_smooth*/
    return new_value;
    
  }
  void reasoning(AudioBuffer mix){
     this.fft.forward(mix);
     this.beat.detect(mix);
     float centroid = compute_centroid(this.fft, this.freqs, this.K); // vemos que tenemos la variable frecuencias que es un array de floats
     float flatness = compute_flatness();
     float spread = compute_spread();                                  
     float skewness= compute_skewness();
     float entropy = compute_entropy();     
     float energy = compute_energy(this.fft, this.K); //para calcular la energia necesitamos un atributo, que es la fft
     
     this.centroid = centroid;    
     this.energy = energy; //this.smooth_filter(this.energy, energy);
     this.flatness = flatness;
     this.spread = spread;
     this.skewness = skewness;
     this.entropy = entropy;  }   
} 
