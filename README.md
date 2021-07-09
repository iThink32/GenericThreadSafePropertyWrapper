# ThreadSafePropertyWrapper

#### Why is it needed?

Have you ever wanted something like @atomic in Swift? , have you ever faced the issue with race conditions in specific properties of your data models?
This repo handles that , be it any type just use this and the accesses to that instance will be threadsafe

#### Why Shared CustomQueue?
- Every application is given a limited number of threads and when you create multiple threads it will eventually lead to thread starvation and your application will enter a memory warning state.This is why i am using a shared concurrent queue.

#### Why barrier on ConcurrentQueue and not on Global queue?
- barriers do not work on global concurrent queues , it words only on custom concurrent queues

#### Usage:

Consider the following model without threadsafety 

```
public class BaseModel {
    public var investedAmount: Decimal
    public var currentInvestmentValue: Decimal
    public var currentReturns: Decimal
    public var currentReturnsPercentage: Decimal

    init(investedAmount: Decimal,
         currentInvestmentValue: Decimal,
         currentReturns: Decimal,
         currentReturnsPercentage: Decimal) {
        self.investedAmount = investedAmount
        self.currentInvestmentValue = currentInvestmentValue
        self.currentReturns = currentReturns
        self.currentReturnsPercentage = currentReturnsPercentage
    }
    
}
```

and with becomes

```
public class BaseModel {
    @ThreadSafe public var investedAmount: Decimal
    @ThreadSafe public var currentInvestmentValue: Decimal
    @ThreadSafe public var currentReturns: Decimal
    @ThreadSafe public var currentReturnsPercentage: Decimal

    init(investedAmount: Decimal,
         currentInvestmentValue: Decimal,
         currentReturns: Decimal,
         currentReturnsPercentage: Decimal) {
        self.investedAmount = investedAmount
        self.currentInvestmentValue = currentInvestmentValue
        self.currentReturns = currentReturns
        self.currentReturnsPercentage = currentReturnsPercentage
    }
    
}
```

Thats it! , your model is now thread safe :)


