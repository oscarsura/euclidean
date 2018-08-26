public class Matrix {
    private static final int kDefaultDimension = 0;
    private int m, n = kDefaultDimension;
    private ArrayList<Vector> matrix;

    public Matrix(int m, int n) {
        this.m = m;
        this.n = n;
        matrix = new ArrayList<Vector>();
    }

    public Matrix(MatrixType matrixType, int m, int n) {
        this(m, n);
        switch (matrixType) {
        case Null:
            defaultMatrix(m, n);
            break;
        case Identity:
            defaultMatrix(m, n);
            for (int row = 0; row < m; row++) {
                for (int col = 0; col < n; col++) {
                    if (row == col) {
                        Vector rowVector = matrix.get(row);
                        int value = 1;
                        rowVector.setAt(col, value);
                    }
                }
            }
            break;
        default:
            break;
        }
    }
    
    public void defaultMatrix(int m, int n) {
        for (int row = 0; row < m; row++) {
            addVector(new Vector(n));
        }   
    }

    //transpose
    //multiply

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
        for (int i = 0; i < m; i++) {
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
        boolean inbounds = (index >= 0) && (index < n);
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
        assert(columnVector.dimension() == m);
        return columnVector;
    }

    @Override
    public String toString() {
    String output = "";
    output += "[";
    for (int i = 0; i < m; i++) {
        Vector row = this.getRowVector(i);
        if (i > 0) output += " ";
        output += row.toString();
        if (i < n - 1) output += ",\n";
    }
    output += "]";
    return output;
    }
}
