package com.newark.model;

public class Account {
    private int acctNumber;
    private String acctName;
    private double acctDeposit;
    private double acctBonus;
    private double acctLotteryWin;

    public Account() {
    }

    public Account(int acctNumber, String acctName, double acctDeposit, double acctBonus, double acctLotteryWin) {
        this.acctNumber = acctNumber;
        this.acctName = acctName;
        this.acctDeposit = acctDeposit;
        this.acctBonus = acctBonus;
        this.acctLotteryWin = acctLotteryWin;
    }

    public int getAcctNumber() {
        return acctNumber;
    }

    public void setAcctNumber(int acctNumber) {
        this.acctNumber = acctNumber;
    }

    public String getAcctName() {
        return acctName;
    }

    public void setAcctName(String acctName) {
        this.acctName = acctName;
    }

    public double getAcctDeposit() {
        return acctDeposit;
    }

    public void setAcctDeposit(double acctDeposit) {
        this.acctDeposit = acctDeposit;
    }

    public double getAcctBonus() {
        return acctBonus;
    }

    public void setAcctBonus(double acctBonus) {
        this.acctBonus = acctBonus;
    }

    public double getAcctLotteryWin() {
        return acctLotteryWin;
    }

    public void setAcctLotteryWin(double acctLotteryWin) {
        this.acctLotteryWin = acctLotteryWin;
    }
} 