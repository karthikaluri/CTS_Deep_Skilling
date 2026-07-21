using Module4_Core;
using Moq;
using NUnit.Framework;

namespace Module4_Tests;

[TestFixture]
public class OrderServiceTests
{
    [Test]
    public void PlaceOrder_SendsEmailWhenCustomerEmailIsValid()
    {
        var emailSender = new Mock<IEmailSender>();
        var service = new OrderService(emailSender.Object);

        service.PlaceOrder("student@example.com");

        emailSender.Verify(x => x.Send("student@example.com", "Order placed successfully."), Times.Once);
    }

    [Test]
    public void PlaceOrder_ThrowsWhenCustomerEmailIsEmpty()
    {
        var emailSender = new Mock<IEmailSender>();
        var service = new OrderService(emailSender.Object);

        var ex = Assert.Throws<ArgumentException>(() => service.PlaceOrder("   "));
        Assert.That(ex!.Message, Does.Contain("Email is required"));
    }
}
