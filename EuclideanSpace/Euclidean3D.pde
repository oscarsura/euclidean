import java.util.*;

public class Euclidean3D {
    private static final int kDefaultScale = 1;
    private static final int dimension = 3;
    private int scale = kDefaultScale;
    private int size = kDefaultScale;
    private float theta = 0.0;
    private boolean show = true;
    private ArrayList<Vector> vectors;
    Matrix projectionMatrix;
    Matrix rotationX;
    Matrix rotationY;
    Matrix rotationZ;
    
    public Euclidean3D(int scale, int size) {
        this.scale = scale;
        this.size = size;
        vectors = new ArrayList<Vector>();
      
        vectors.add(new Vector(new float[]{1, 1, 1})); 
        vectors.add(new Vector(new float[]{1, 1, -1})); 
        vectors.add(new Vector(new float[]{1, -1, 1})); 
        vectors.add(new Vector(new float[]{1, -1, -1})); 
        vectors.add(new Vector(new float[]{-1, 1, 1})); 
        vectors.add(new Vector(new float[]{-1, 1, -1}));
        vectors.add(new Vector(new float[]{-1, -1, 1}));
        vectors.add(new Vector(new float[]{-1, -1, -1}));
        
        rotationX = new Matrix(3, 3);
        rotationY = new Matrix(3, 3);
        rotationZ = new Matrix(3, 3);
        projectionMatrix = new Matrix(3, 3);
        projectionMatrix.addVector(new Vector(new float[]{1, 0, 0}));
        projectionMatrix.addVector(new Vector(new float[]{0, 1, 0}));
        projectionMatrix.addVector(new Vector(new float[]{0, 0, 0}));    
    }
    
    public void updateMatrices() {
        rotationX.clearAll();
        rotationY.clearAll();
        rotationZ.clearAll();
        
        rotationX.addVector(new Vector(new float[]{1, 0, 0}));
        rotationX.addVector(new Vector(new float[]{0, (float)Math.cos(theta), (float)-Math.sin(theta)}));
        rotationX.addVector(new Vector(new float[]{0, (float)Math.sin(theta), (float)Math.cos(theta)}));
        
        rotationY.addVector(new Vector(new float[]{(float)Math.cos(theta), 0, (float)Math.sin(theta)}));
        rotationY.addVector(new Vector(new float[]{0, 1, 0}));
        rotationY.addVector(new Vector(new float[]{(float)-Math.sin(theta), 0, (float)Math.cos(theta)}));
        
        rotationZ.addVector(new Vector(new float[]{(float)Math.cos(theta), (float)-Math.sin(theta), 0}));
        rotationZ.addVector(new Vector(new float[]{(float)Math.sin(theta), (float)Math.cos(theta), 0}));
        rotationZ.addVector(new Vector(new float[]{0, 0, 1}));
    }
    
    public void rotate(float theta) {
        this.theta = theta;
        updateMatrices();
        for (int i = 0; i < vectors.size(); i++) {
            Vector rotatedVector = rotationX.projectVector(vectors.get(i));
            rotatedVector = rotationX.projectVector(rotatedVector);
            rotatedVector = rotationZ.projectVector(rotatedVector);
            vectors.set(i, rotatedVector);     
        }
    }
    
    public void toggle() {
        show = !show;    
    }
    
    private static final float epsilon = 0.0001;
    public boolean adjacent(Vector v1, Vector v2) {
        return 1 - v1.dotProduct(v2) < epsilon;
    }
    
    public void drawShape(color c) {
        if (!show) return;
        stroke(c);
        for (Vector v : vectors) {
            Vector projected = projectionMatrix.projectVector(v);
            ellipse(projected.getAt(0)*scale, projected.getAt(1)*scale, size, size);
        }
        strokeWeight(2);
        for (int i = 0; i < vectors.size(); i++) {
            for (int j = 0; j < vectors.size(); j++) {
                 Vector v1 = vectors.get(i);
                 Vector v2 = vectors.get(j);
                 if (adjacent(v1, v2)) {
                     line(v1.getAt(0)*scale, v1.getAt(1)*scale, v2.getAt(0)*scale, v2.getAt(1)*scale);    
                 }
            }
        }
    }
}
