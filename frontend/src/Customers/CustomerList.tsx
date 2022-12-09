import { useState, useEffect } from "react"
import { Customer } from "./Customer"
import { CustomerForm } from './CustomerForm'
import { ICustomer } from "../types/data"
import axios from 'axios';

export const CustomerList = () => {
  const [customers, setCustomers] = useState<ICustomer[]>([])
  const [isUpdate, setUpdate] = useState<boolean>(false)

  useEffect(() => {
    getCustomers()
    setUpdate(false)
  }, [isUpdate])

  const getCustomers = async () => {
    try {
      const response = await axios
        .get('http://localhost:3000/api/customers')

      const data = response.data

      setCustomers(data.reverse())

    } catch(error: any) {
      console.log(error)
    }
  }

  const updateCustomerList = (customer: ICustomer) => {
    let _customers = customers;
    _customers.unshift(customer);
    setCustomers(_customers);

    setUpdate(true)
  }

  return (
    <>
      <CustomerForm updateCustomerList={updateCustomerList} />

      {customers.map((customer: ICustomer) => (
        <Customer
          key={customer.id}
          name={customer.name}
          addresses={customer.addresses}
        />
      ))}
    </>
  )
}