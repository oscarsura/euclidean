public class Matrix {
    private static final int kDefaultDimension = 0;
    private int dimension = kDefaultDimension;
    private ArrayList<Vector> matrix;
    
    public Matrix(int dimension) {
        this.dimension = dimension;
        matrix = new ArrayList<Vector>();
    }
}
