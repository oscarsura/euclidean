public class Euclidean2D {
    private static final int kDefaultScale = 1;
    private int scale = kDefaultScale;
    private static final int dimension = 2;
    private int size = kDefaultScale;
    private boolean show = true;
    private ArrayList<Vector> vectors;
    
    public Euclidean2D(int scale, int size) {
        this.scale = scale;
        this.size = size;
        vectors = new ArrayList<Vector>();
        vectors.add(new Vector(new float[]{-1, 1}));
        vectors.add(new Vector(new float[]{1, 1}));
        vectors.add(new Vector(new float[]{1, -1}));
        vectors.add(new Vector(new float[]{-1, -1}));
    }
    
    public void rotate(float theta) {
        Vector row1 = new Vector((float)Math.cos(theta), (float)-Math.sin(theta));
        Vector row2 = new Vector((float)Math.sin(theta), (float)Math.cos(theta));
        Matrix rotationMatrix = new Matrix(2, 2);
        rotationMatrix.addVector(row1);
        rotationMatrix.addVector(row2);
        for (int i = 0; i < vectors.size(); i++) {
            Vector rotatedVector = rotationMatrix.projectVector(vectors.get(i));
            vectors.set(i, rotatedVector);     
        }
    }
    
    public void toggle() {
        show = !show;    
    }
    
    public void drawShape(color c) {
        if (!show) return;
        stroke(c);
        for (Vector v : vectors) {
            ellipse(v.getAt(0)*scale, v.getAt(1)*scale, size, size);
        }
        strokeWeight(2);
        for (int i = 0; i < 4; i++) {
            Vector a = vectors.get(i);
            Vector b = vectors.get((i+1)%(dimension*2));
            line(a.getAt(0)*scale, a.getAt(1)*scale, b.getAt(0)*scale, b.getAt(1)*scale);
        }
    }
}
