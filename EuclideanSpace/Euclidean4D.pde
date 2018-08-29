import java.util.*;

public class Euclidean4D {
    private static final int kDefaultScale = 1;
    private static final int dimension = 3;
    private int scale = kDefaultScale;
    private int size = kDefaultScale;
    private float theta = 0.0;
    private boolean show = true;
    private ArrayList<Vector> vectors;
    Matrix projectionMatrix;
    Matrix rotationXY;
    Matrix rotationYZ;
    Matrix rotationXZ;
    Matrix rotationXU;
    Matrix rotationYU;
    Matrix rotationZU;
    
    public Euclidean4D(int scale, int size) {
        this.scale = scale;
        this.size = size;
        vectors = new ArrayList<Vector>();
      
        vectors.add(new Vector(new float[]{1, 1, 1, 1})); 
        vectors.add(new Vector(new float[]{1, 1, 1, -1})); 
        vectors.add(new Vector(new float[]{1, 1, -1, 1}));
        vectors.add(new Vector(new float[]{1, 1, -1, -1}));
        
        vectors.add(new Vector(new float[]{1, -1, 1, 1})); 
        vectors.add(new Vector(new float[]{1, -1, 1, -1})); 
        vectors.add(new Vector(new float[]{1, -1, -1, 1})); 
        vectors.add(new Vector(new float[]{1, -1, -1, -1})); 
        
        vectors.add(new Vector(new float[]{-1, 1, 1, 1})); 
        vectors.add(new Vector(new float[]{-1, 1, 1, -1})); 
        vectors.add(new Vector(new float[]{-1, 1, -1, 1})); 
        vectors.add(new Vector(new float[]{-1, 1, -1, -1})); 
        
        vectors.add(new Vector(new float[]{-1, -1, 1, 1})); 
        vectors.add(new Vector(new float[]{-1, -1, 1, -1})); 
        vectors.add(new Vector(new float[]{-1, -1, -1, 1})); 
        vectors.add(new Vector(new float[]{-1, -1, -1, -1})); 
        
        rotationXY = new Matrix(4,4);
        rotationYZ = new Matrix(4,4);
        rotationXZ = new Matrix(4,4);
        rotationXU = new Matrix(4,4);
        rotationYU = new Matrix(4,4);
        rotationZU = new Matrix(4,4);
        projectionMatrix = new Matrix(4, 4);
        projectionMatrix.addVector(new Vector(new float[]{1, 0, 0, 0}));
        projectionMatrix.addVector(new Vector(new float[]{0, 1, 0, 0}));
        projectionMatrix.addVector(new Vector(new float[]{0, 0, 0, 0}));
        projectionMatrix.addVector(new Vector(new float[]{0, 0, 0, 0})); 
    }
    
    public void updateMatrices() {

        rotationXY.clearAll();
        rotationYZ.clearAll();
        rotationXZ.clearAll();
        rotationXU.clearAll();
        rotationYU.clearAll();
        rotationZU.clearAll();
        
        rotationXY.addVector(new Vector((float)Math.cos(theta), (float)Math.sin(theta), 0, 0));
        rotationXY.addVector(new Vector((float)-Math.sin(theta), (float)Math.cos(theta), 0, 0));
        rotationXY.addVector(new Vector(0, 0, 1, 0));
        rotationXY.addVector(new Vector(0, 0, 0, 1));
        
        rotationYZ.addVector(new Vector(1, 0, 0, 0));
        rotationYZ.addVector(new Vector(0, (float)Math.cos(theta), (float)Math.sin(theta), 0));
        rotationYZ.addVector(new Vector(0, (float)-Math.sin(theta), (float)Math.cos(theta), 0));
        rotationYZ.addVector(new Vector(0, 0, 0, 1));
        
        rotationXZ.addVector(new Vector((float)Math.cos(theta), 0, (float)-Math.sin(theta), 0));
        rotationXZ.addVector(new Vector(0, 1, 0, 0));
        rotationXZ.addVector(new Vector((float)Math.sin(theta), 0, (float)Math.cos(theta), 0));
        rotationXZ.addVector(new Vector(0, 0, 0, 1));
        
        rotationXU.addVector(new Vector((float)Math.cos(theta), 0, 0, (float)Math.sin(theta)));
        rotationXU.addVector(new Vector(0, 1, 0, 0));
        rotationXU.addVector(new Vector(0, 0, 1, 0));
        rotationXU.addVector(new Vector((float)-Math.sin(theta), 0, 0, (float)Math.cos(theta)));
        
        rotationYU.addVector(new Vector(1, 0, 0, 0));
        rotationYU.addVector(new Vector(0, (float)Math.cos(theta), 0, (float)-Math.sin(theta)));
        rotationYU.addVector(new Vector(0, 0, 1, 0));
        rotationYU.addVector(new Vector(0, (float)Math.sin(theta), 0, (float)Math.cos(theta)));
        
        rotationZU.addVector(new Vector(1, 0, 0, 0));
        rotationZU.addVector(new Vector(0, 1, 0, 0));
        rotationZU.addVector(new Vector(0, 0, (float)Math.cos(theta), (float)-Math.sin(theta)));
        rotationZU.addVector(new Vector(0, 0, (float)Math.sin(theta), (float)Math.cos(theta)));
    }
    
    public void rotate(float theta) {
        this.theta = theta;
        updateMatrices();
        for (int i = 0; i < vectors.size(); i++) {
            Vector rotatedVector = rotationXY.projectVector(vectors.get(i));
            rotatedVector = rotationYZ.projectVector(rotatedVector);
            rotatedVector = rotationXZ.projectVector(rotatedVector);
            rotatedVector = rotationXU.projectVector(rotatedVector);
            rotatedVector = rotationYU.projectVector(rotatedVector);
            rotatedVector = rotationZU.projectVector(rotatedVector);
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
