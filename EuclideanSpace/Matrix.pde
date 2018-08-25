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

    public Vector getRowVector(int index) {
        boolean inbounds = (index >= 0) && (index < matrix.size());
        if (!inbounds) return new Vector();
        return matrix.get(index);
    }
    
    public Vector getColumnVector(int index) {
        boolean inbounds = (index >= 0) && (index < m);
        if (!inbounds) return new Vector();
        Vector columnVector = new Vector();
        for (Vector rowVector : matrix) {
            for (int i = 0; i < rowVector.dimension(); i++) {
                if (i == index) {
                    int toAdd = rowVector.getAt(i);
                    columnVector.addComponent(toAdd);
                }
                if (i > index) break;
            }
        }
        assert(columnVector.dimension() == n);
        return columnVector;
    }
}
