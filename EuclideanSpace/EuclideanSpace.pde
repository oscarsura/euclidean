void setup() {
    Matrix identity = new Matrix(MatrixType.Identity, 3, 3);
    Matrix numerals = new Matrix(new int[]{1, 2, 3}, new int[]{4, 5, 6}, new int[]{7, 8, 9});
    Matrix product = identity.multiply(numerals);
    
    println("The original matrix:");
    println(numerals.toString());
    println("The result is:");
    println(product.toString());
}
void draw() {}
