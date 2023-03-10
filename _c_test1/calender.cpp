/*
* 程序的版權和版本聲明部分
* Copyright (c)2012, 煙台大學計算機學院學生
* All rightsreserved.
* 文件名稱： object.cpp
* 作者：紀子龍
* 完成日期： 2013年3  月 21 日
* 版本號： v1.0
* 輸入描述：無
* 問題描述：無
* 程序輸出：無
*/
#include <iostream>
#include <iomanip>
using namespace std;
class Date
{
private:
    int year;
    int month;
    int day;
    int monthDay[12];
public:
    Date(int y=1, int m=1, int d=1):year(y),month(m),day(d)//在聲明構造函數的同時指定默認參數
    {
        monthDay[0]=monthDay[2]=monthDay[4]=monthDay[6]=monthDay[7]=monthDay[9]=monthDay[11]=31;
        monthDay[1]=28;
        monthDay[3]= monthDay[5]= monthDay[8]= monthDay[10]=30;
    }//給每月賦天數值
    void SetYear(int y) { year=y; }
    void SetMonth(int m) { month=m; }
    void SetDay(int d) { day=d; }//設置年月日
    int GetYear() const { return year; }
    int GetMonth() const { return month; }
    int GetDay() const { return day; }
    int GetMonthDay(const int i)
    {
        if(i==2&&Isleapyear(year))
            return 29;
        return monthDay[i-1];
    }

    bool Isleapyear(int y)          //  判斷是否為閏年。
    {
        return ((y%4==0 && y%100!=0)||(y%400==0));
    }

    int GetYearDays(int y)          //  年份y的天數。
    {
        if(Isleapyear(y))
            return 366;
        return 365;
    }

    int DateToNum()     //  給定日期，返回天數。
    {
        int sum=0;
        int i=0;
        for(i=1;i<year;i++)
            sum+=GetYearDays(i);
        if(Isleapyear(year))
            monthDay[1]=29;
        else
            monthDay[1]=28;
        for(int j=1;j<month;j++)
            sum+=monthDay[j-1];
        return sum+day;
    }

    Date NumToDay(int n)                //  給定天數，返回日期。
    {
        Date d(1, 1, 1);
        for(;n>=GetYearDays(d.year);d.year++)
            n-=GetYearDays(d.year);
        if(Isleapyear(d.year))
            monthDay[1]=29;
        else
            monthDay[1]=28;
        for(;n>=monthDay[d.month];d.month++)
            n-=monthDay[d.month];
        d.day=n;
        return d;
    }

    void OutputYearDate(int y)          //  給定年份y，輸出年份y的日歷。
    {
        if(y<=0)
            return;
        int i=0;
        int j=0;
        Date d;
        d.year=y;
        d.day=1;
        cout<<endl<<endl<<setw(20)<<y<<"年"<<endl;
        while(i++<12)
        {
            cout<<endl<<endl<<setw(15)<<i<<" 月"<<endl;
            cout<<endl
                <<setw(5)<<"SUN"
                <<setw(5)<<"MON"
                <<setw(5)<<"TUE"
                <<setw(5)<<"WED"
                <<setw(5)<<"THU"
                <<setw(5)<<"FRI"
                <<setw(5)<<"SAT"
                <<endl;
            cout<<"-----------------------------------"<<endl;
            j=0;
            d.month=i;
            cout<<setw(5*(d.DateToNum()%7)+5)<<1;
            for(j=1;j<monthDay[i-1];j++)
            {
                if((j+(d.DateToNum()%7))%7==0)
                    cout<<endl;
                cout<<setw(5)<<j+1;
            }
            cout<<endl;
            cout<<"-----------------------------------"<<endl;
        }
    }

    void OutputYearMonthDate(int y, int m)//給定年y，月m，輸出y年m月的日歷
    {
        if(y<=0)
            return;
        Date d(y, m, 1);
        cout<<endl<<endl<<setw(15)<<m<<" 月"<<endl;
        cout<<endl
            <<setw(5)<<"SUN"
            <<setw(5)<<"MON"
            <<setw(5)<<"TUE"
            <<setw(5)<<"WED"
            <<setw(5)<<"THU"
            <<setw(5)<<"FRI"
            <<setw(5)<<"SAT"
            <<endl;
        cout<<"-----------------------------------"<<endl;
        cout<<setw(5*(d.DateToNum()%7)+5)<<1;
        for(int j=1;j<monthDay[m-1];j++)
        {
            if((j+(d.DateToNum()%7))%7==0)
                cout<<endl;
            cout<<setw(5)<<j+1;
        }
        cout<<endl;
        cout<<"-----------------------------------"<<endl;
    }

    static int Week(Date d)
    {
        if(d.DateToNum()%7==0)
            return 7;
        return(d.DateToNum()%7);
    }
};

int main(void)
{
    Date d;
    int number;
    char choose;
    bool flag=true;
    while(flag)
    {
        cout<<endl<<"       =======》》使用說明《《======"<<endl<<endl;
        cout<<"                   　　　｜｜"<<endl;
        cout<<"                 　　　｜｜"<<endl;
        cout<<"                 　　　╲╱　"<<endl<<endl;
        cout<<"               設公元年月日為第一天   "<<endl<<endl;
        cout<<"       輸入  ==》　１　打印　某年　的日歷；"<<endl<<endl;
        cout<<"       輸入  ==》　２　查看某年是否是閏年；"<<endl<<endl;
        cout<<"       輸入  ==》　３　查看某日期是星期幾；"<<endl<<endl;
        cout<<"       輸入  ==》　４　查看某年某月的日歷；"<<endl<<endl;
        cout<<"       輸入  ==》　５　給定天數，返回日期；"<<endl<<endl;
        cout<<"       輸入  ==》　６　退　　　　出；"<<endl<<endl;
        cout<<"輸入您的選擇：";
        cin>>choose;
        while (getchar()!='\n');
        if(!cin)
        {
            cin.clear();
            cin.sync();
            cout<<"輸入錯誤";
            system("pause");
            system("cls");
            continue;
        }
        switch(choose)
        {
        case '1':
            cout<<"輸入年：";
            cin>>number;
            d.SetYear(number);
            if(d.GetYear()<=0)
            {
                cout<<"輸入年份有錯，返回。"<<endl;
                system("pause");
                system("cls");
                break;
            }
            d.OutputYearDate(d.GetYear());
            system("pause");
            system("cls");
            break;
        case '2':
            cout<<"輸入年：";
            cin>>number;
            d.SetYear(number);
            if(d.GetYear()<=0)
            {
                cout<<"輸入年份有錯，返回。"<<endl;
                system("pause");
                system("cls");
                break;
            }
            if(d.Isleapyear(d.GetYear()))
                cout<<"閏年。"<<endl;
            else
                cout<<"非閏年."<<endl;
            system("pause");
            system("cls");
            break;
        case '3':
            cout<<"輸入年：";
            cin>>number;
            d.SetYear(number);
            cout<<"輸入月：";
            cin>>number;
            d.SetMonth(number);
            cout<<"輸入日：";
            cin>>number;
            d.SetDay(number);
            if(d.GetYear()<=0||d.GetMonth()>12||d.GetMonth()<1||d.GetDay()<1||d.GetDay()>d.GetMonthDay(2))
            {
                cout<<"輸入有誤，返回。"<<endl;
                system("pause");
                system("cls");
                break;
            }
            cout<<"星期"<<Date::Week(d)<<endl;
            system("pause");
            system("cls");
            break;
        case '4':
            cout<<"輸入年：";
            cin>>number;
            d.SetYear(number);
            cout<<"輸入月：";
            cin>>number;
            d.SetMonth(number);
            if(d.GetYear()<=0||d.GetMonth()>12||d.GetMonth()<1)
            {
                cout<<"輸入有誤，返回。"<<endl;
                system("pause");
                system("cls");
                break;
            }
            d.OutputYearMonthDate(d.GetYear(),d.GetMonth());
            system("pause");
            system("cls");
            break;
        case '5':
            cout<<"輸入天數：";
            cin>>number;
            if(number<=0)
            {
                cout<<"輸入有誤，返回。"<<endl;
                system("pause");
                system("cls");
                break;
            }
            cout<<"年："<<d.NumToDay(number).GetYear()<<endl;
            cout<<"月："<<d.NumToDay(number).GetMonth()<<endl;
            cout<<"日："<<d.NumToDay(number).GetDay()<<endl;
            system("pause");
            system("cls");
            break;
        case '6':
            exit(1);
        default:
            cout<<"輸入錯誤，請重新輸入";
            system("pause");
            system("cls");
        }
    }
    return 0;
}

