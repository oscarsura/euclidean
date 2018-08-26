public class Matrix {
    private static final int kDefaultDimension = 0;
    private int n, m = kDefaultDimension;
    private ArrayList<Vector> matrix;
    
    public Matrix(int n, int m) {
        this.n = n;
        this.m = m;
        matrix = new ArrayList<Vector>();
    }
    
    public static final int kEmptyComponent = 0;
    public Matrix(int[] ...rows) {
        matrix = new ArrayList<Vector>();
        int dimension = 0;
        for (int[] row : rows) {
            Vector rowVector = new Vector(row);
            this.addVector(rowVector);
            if (rowVector.dimension() > dimension) {
                dimension = rowVector.dimension();   
            }
            n++;
        }
        
        for (Vector rowVector : matrix) {
            if (rowVector.dimension() < dimension) {
                int diff = dimension - rowVector.dimension();
                for (int i = 0; i < diff; i++) {
                    rowVector.addComponent(kEmptyComponent);   
                }
            }
        }
    }
    
    public void addVector(Vector vector) {
        matrix.add(vector);
    }
    
    public Vector projectVector(Vector columnVector) {
        Vector projection = new Vector();
        for (int i = 0; i < n; i++) {
            Vector rowVector = this.getRowVector(i);
            int component = rowVector.dotProduct(columnVector);
            projection.addComponent(component);   
        }
        return projection;
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
    
    @Override
    public String toString() {
        String output = "";
        output += "[";
        //n has never been set!!! neither has m!!!
        for (int i = 0; i < n; i++) {
            Vector row = this.getRowVector(i);
            if (i > 0) output += " ";
            output += row.toString();
            if (i < n - 1) output += ",\n";
        }
        output += "]";
        return output;
    }
}
