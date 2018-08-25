public class Matrix {
    private static final int kDefaultDimension = 0;
    private int n, m = kDefaultDimension;
    private ArrayList<Vector> matrix;
    
    public Matrix(int n, int m) {
        this.n = n;
        this.m = m;
        matrix = new ArrayList<Vector>();
    }
    
    public void addVector(Vector v) {
        matrix.add(v);    
    }
    
    private static final int kOutOfBounds = -1;
    public Vector getRow(int index) {
        boolean inbounds = (index >= 0) && (index < matrix.size());
        if (!inbounds) return new Vector();
        return matrix.get(index);
    }
    
    public Vector getColumn(int index) {
        boolean inbounds = (index >= 0) && (index < m);
        if (!inbounds) return new Vector();
        
    }
}
