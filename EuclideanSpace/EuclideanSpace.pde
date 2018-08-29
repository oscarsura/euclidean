void setup() {
    size(800, 800);
    background(50, 30, 100);
}

private boolean random = false;
private float theta = 0.01;
private float delta = 0.000001;
private Euclidean4D cube = new Euclidean4D(100, 4);
void draw() {
    background(0);
    translate(width/2, height/2);
    color shapeColor = random ? color(random(255), random(255), random(255)) : color(255, 255, 255);
    cube.drawShape(shapeColor);
    cube.rotate(theta);
    theta += delta;
}
