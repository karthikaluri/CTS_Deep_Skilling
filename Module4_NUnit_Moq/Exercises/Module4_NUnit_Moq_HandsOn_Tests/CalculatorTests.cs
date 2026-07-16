using Module4_Core;
using NUnit.Framework;

namespace Module4_Tests;

[TestFixture]
public class CalculatorTests
{
    private Calculator _calculator = null!;

    [SetUp]
    public void Setup()
    {
        _calculator = new Calculator();
    }

    [Test]
    public void Add_ReturnsSum()
    {
        var result = _calculator.Add(2, 3);
        Assert.That(result, Is.EqualTo(5));
    }

    [Test]
    public void Multiply_ReturnsProduct()
    {
        var result = _calculator.Multiply(4, 5);
        Assert.That(result, Is.EqualTo(20));
    }

    [Test]
    public void Divide_ThrowsForZero()
    {
        Assert.Throws<DivideByZeroException>(() => _calculator.Divide(10, 0));
    }
}
