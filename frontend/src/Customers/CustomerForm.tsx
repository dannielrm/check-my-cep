import axios from "axios";
import { ICustomer } from "../types/data"
import { useForm } from "react-hook-form";
import { useState } from "react";
import { Button, Form } from "react-bootstrap";

export const CustomerForm = (props: { updateCustomerList: (customer: ICustomer) => void; }) => {
  const [json, setJson] = useState<string>('')

  const { register, handleSubmit, formState: { errors } } = useForm();

  const onSubmit = async () => {
    const customerData = {json}.json

    try {
      const reqConfig = {
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      };
      const response = await axios
        .post('http://localhost:3000/api/customers', customerData, reqConfig)

        props.updateCustomerList(response.data)
     } catch(error: any) {
      console.log(error)
    }
  }

  return (
    <>
      <Form onSubmit={handleSubmit(onSubmit)}>
        <Form.Group>
          <Form.Label>Paste your JSON here</Form.Label>
          <Form.Control
            {...register("json", {required: true})}
            type="textarea"
            name="json"
            placeholder="Please don't use, this is not working"
            onChange={e => setJson(e.target.value)}
          />
          {errors?.title?.type === "required" && <p>This field is required</p>}
        </Form.Group>

        <Button variant="primary" type="submit">
          Submit
        </Button><hr />
      </Form>
    </>
  )
}