public class Vector {
    
    private static final int kDefaultDimension = 0;
    private int dimension; 
    private float[] vector;
    
    public Vector() {
        this.dimension = kDefaultDimension;
        vector = new float[0];
    }
    
    public static final int kDefaultComponent = 0;
    public Vector(int dimension) {
        this.dimension = dimension;
        vector = new float[dimension];
        for (int i = 0; i < dimension; i++) {
            vector[i] = kDefaultComponent;
        }
    }
    
    public Vector(float... vector) {
        this.dimension = vector.length;
        this.vector = new float[dimension];
        
        for (int i = 0; i < dimension; i++) {
            this.vector[i] = vector[i];        
        }
    }
    
    public void addComponent(float value) {
        float[] newVector = new float[++dimension];
        int index;
        for (index = 0; index < vector.length; index++) {
            newVector[index] = vector[index];   
        }
        newVector[index] = value;
        vector = newVector;
    }
    
    private static final int kOutOfBounds = -1;
    public float getAt(int index) {
        boolean inBounds = (index >= 0) && (index < vector.length);
        return inBounds ? vector[index] : kOutOfBounds;
    }
    
    public void setAt(int index, float value) {
        boolean inBounds = (index >= 0) && (index < vector.length);
        if (inBounds) vector[index] = value;
    }
    
    private static final int kDimensionMismatch = -1;
    public float dotProduct(Vector vector2) {
        float product = 0;
        float[] w = vector2.asArray();
        float[] v = vector;
        
        int components = (w.length == v.length) ? dimension : kDimensionMismatch;
        for (int i = 0; i < components; i++) {
            product += (w[i] * v[i]);        
        }
        return product;
    }
    
    public float angle(Vector vector2) {
        float dp = this.dotProduct(vector2);
        float mag = this.magnitude() * vector2.magnitude();
        return (float)Math.acos(dp / mag);
    }
    
    public float magnitude() {
        int squaredSum = 0;
        for (float i : vector) {
            squaredSum += Math.pow(i, 2);
        }
        return (float)Math.pow(squaredSum, 1/2);  
    }
    
    public int dimension() {
        return dimension;    
    }
    
    public float[] asArray() {
        return vector;    
    }
    
    @Override
    public String toString() {
        String output = "";
        output += "(";
        for (int i = 0; i < dimension; i++) {
            output += Float.toString(vector[i]);
            if (i < dimension - 1) output += ", ";
        }
        output += ")";
        return output;
    }
}
