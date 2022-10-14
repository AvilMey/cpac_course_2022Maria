ParticleSystem ps;
int Nparticles=100;
PImage img;

void setup(){
  size(1024,500, P2D);
  img = loadImage("texture.png");
  ps=new ParticleSystem();
  for(int p=0; p<Nparticles; p++){
    ps.addParticle();
  }
  background(0);
}

void draw(){
  blendMode(ADD);
  background(0);
  //computeEnergy();
  //ps.origin=new PVector(mouseX, mouseY);
  
  ps.draw();
}
