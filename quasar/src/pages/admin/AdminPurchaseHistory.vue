<template>
  <q-page padding>
    <div>
      <div class="radio">
        <q-radio v-model="radio" val="food" color="blue" label="Обед" />
        <q-radio v-model="radio" val="bake" color="blue" label="Выпечка" style="margin-left: 10px" />
      </div>
        <!--ЕДА + ПОСУДА-->
      <div v-if="radio == 'food'" class="food">
          <div style="overflow: hidden">
            <p class="date">Выберите дату:</p>
            <q-datetime @change="postDate" format="DD.MM.YYYY" class="datetime" v-model="dateDish"/>
            <p style="color: red;">{{ error }}</p>
          </div>
          <div ref="content">
          <h5 class="dateFor">Обед на {{ dateOrders }}</h5>
          <table class="q-table">
            <thead>
            <tr>
              <th class="firstColumnAll">Наименование</th>
              <th class="secondColumnAll">Цена</th>
              <th class="thirdColumnAll">Количество</th>
              <th class="fourthColumnAll">Сумма</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="item in ordersInfoRequirements">
              <td class="name" v-if="item.name">{{ item.name}}</td>
              <td v-if="item.price">{{ item.price }}</td>
              <td v-if="item.count">{{ item.count }}</td>
              <td v-if="item.total">{{ item.total }}</td>
            </tr>
            <tr v-for="item in ordersInfo">
              <td class="name" v-if="item.name">{{ item.name + ' ' + '(' + item.weight + ')' }}</td>
              <td v-if="item.price">{{ item.price }}</td>
              <td v-if="item.count">{{ item.count }}</td>
              <td v-if="item.total">{{ item.total }}</td>
            </tr>
            <tr>
              <td class="name"><b>Итого</b></td>
              <td></td>
              <td></td>
              <td><b>{{ ordersInfo.totalSum }}</b></td>
            </tr>
            </tbody>
          </table>

          <h5 class="dateFor">Расфасовка</h5>
          <table class="q-table">
            <thead>
            <tr>
              <th class="firstColumnUser">id</th>
              <th class="secondColumnUser">Блюда</th>
              <th class="thirdColumnUser">Сумма</th>
            </tr>
            </thead>
            <tbody>
              <tr v-for="item in Object.keys(perUserInfo)" v-if="perUserInfo[item].totalSumUser != 0.00">
                  <td>{{ item }}</td>
                  <td>
                    <div class="row text-center" v-for="items in perUserInfo[item]">
                      <span class="nameUser" v-if="items.name">{{ items.name + ' ' + '(' + items.weight + ')' + ' ' + '-' + ' ' + items.count + ' ' + 'порц.'}}</span>
                    </div><br>
                  </td>
                  <td>
                    {{ perUserInfo[item].totalSumUser }}
                  </td>
              </tr>
            </tbody>
          </table>
          </div>
          <div style="overflow: hidden;" class="btn">
            <q-btn @click="getPDF" class="btn_absent shadow-0" label="Скачать в PDF" />
          </div>
      </div>

          <!--ВЫПЕЧКА-->
        <div v-if="radio == 'bake'" class="bake">
            <div style="overflow: hidden">
              <p class="date">Выберите дату:</p>
              <q-datetime @change="getBake" format="DD.MM.YYYY" class="datetime" v-model="dateBake"/>
              <p style="color: red;">{{ error }}</p>
            </div>
            <div ref="content">
              <h5 class="dateFor">Обед на {{ dateOrdersBake }}</h5>
              <table class="q-table">
                <thead>
                <tr>
                  <th class="firstColumnAll">Наименование</th>
                  <th class="secondColumnAll">Цена</th>
                  <th class="thirdColumnAll">Количество</th>
                  <th class="fourthColumnAll">Сумма</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="item in ordersInfoBake">
                  <td class="name" v-if="item.name">{{ item.name }}</td>
                  <td v-if="item.price">{{ item.price }}</td>
                  <td v-if="item.count">{{ item.count }}</td>
                  <td v-if="item.total">{{ item.total }}</td>
                </tr>
                <tr>
                  <td class="name"><b>Итого</b></td>
                  <td></td>
                  <td></td>
                  <td><b>{{ ordersInfoBake.totalSum }}</b></td>
                </tr>
                </tbody>
              </table>

              <h5 class="dateFor">Расфасовка</h5>
              <table class="q-table">
                <thead>
                <tr>
                  <th class="firstColumnUser">id</th>
                  <th class="secondColumnUser">Блюда</th>
                  <th class="thirdColumnUser">Сумма</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="item in Object.keys(perUserInfoBake)" v-if="perUserInfoBake[item].totalSumUser != 0.00">
                  <td>{{ item }}</td>
                  <td>
                    <div class="row text-center" v-for="items in perUserInfoBake[item]">
                      <span class="nameUser" v-if="items.name">{{ items.name }}</span>
                    </div><br>
                  </td>
                  <td>
                    {{ perUserInfoBake[item].totalSumUser }}
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
            <div style="overflow: hidden;" class="btn">
              <q-btn @click="getPDFBake" class="btn_absent shadow-0" label="Скачать в PDF" />
            </div>
          </div>
        </div>
  </q-page>
</template>

<script>
  import * as jsPDF  from "jspdf";
  import html2canvas from 'html2canvas';
  import * as CryptoJS from 'crypto-js';

export default {
  name: 'PurchaseHistory',
  data() {
    return {
      separator: 'horizontal',
      dateDish: new Date(),
      dateBake: new Date(),
      error: '',
      ordersInfo: '',
      perUserInfo: [],
      ordersInfoRequirements: [],
      dateOrders: '',
      radio: 'food',
      ordersInfoBake: '',
      perUserInfoBake: [],
      dateOrdersBake: ''

    }
  },
  mounted() {
    this.postDate();
    this.getBake();
  },
  methods: {
    postDate() {
      this.$axios.post('/get-order-date', {
        dateDish: this.dateDish
      }).then(response => {
        if (response.data == 'выберите дату') {
          this.data = response.data;
          this.error = response.data;
        } else {
          this.data = response.data;
          this.error = '';
          this.ordersInfo = response.data.ordersInfo;
          this.perUserInfo = response.data.perUserInfo;
          this.dateOrders = response.data.dateOrders;
          this.ordersInfoRequirements = response.data.ordersInfoRequirements;

        }
      })
      .catch((err) => {
        alert('Ошибка');
        console.log(err)
      })
    },
    downloadWithCSS() {
      var fileName = CryptoJS.MD5(this.model) + '.pdf';
      const doc = new jsPDF();
      var canvasElement = document.createElement('canvas');
      html2canvas(this.$refs.content, { canvas: canvasElement
      }).then(function (canvas) {
        const img = canvas.toDataURL("image/png");
        doc.addImage(img,'JPEG',20,20);
        doc.save(fileName);
      });
    },
    getPDF() {
      this.$axios.post("/generate-pdf-dish",
              {
                dateDish: this.dateDish
              },
              {
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/pdf'
                },
                responseType: "blob"
      }).then((response) => {
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', CryptoJS.MD5(this.model) + '.pdf');
        document.body.appendChild(link);
        link.click();
      });
    },
    getPDFBake() {
      this.$axios.post("/generate-pdf-bake",
              {
                dateBake: this.dateBake
              },
              {
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/pdf'
                },
                responseType: "blob"
              }).then((response) => {
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', CryptoJS.MD5(this.model) + '.pdf');
        document.body.appendChild(link);
        link.click();
      });
    },
    getBake() {
      this.$axios.post('/get-bake', {
        dateBake: this.dateBake
      }).then(response => {
        if (response.data == 'выберите дату') {
          this.data = response.data;
          this.error = response.data;
        } else {
          this.data = response.data;
          this.error = '';
          this.ordersInfoBake = response.data.ordersInfo;
          this.perUserInfoBake = response.data.perUserInfo;
          this.dateOrdersBake = response.data.dateOrders;
        }
      })
      .catch((err) => {
        alert('Ошибка');
        console.log(err)
      })
    },
  }
}
</script>

<style scoped>
    tr,
    th,
    td {
      border: 0.25px solid #000000;
      font-size: 14px;
      color: #555555;
      font-family: Montserrat;
      font-style: normal;
      font-weight: 500;
    }
    .radio {
      font-style: normal;
      font-weight: bold;
      font-size: 16px;
      color: #0C4CBC;
      margin-bottom: 12px;
    }
    .q-if .q-if-inner {
      font-family: Montserrat;
      font-style: normal;
      font-weight: normal;
      font-size: 14px;
      color: #0C4CBC;
      margin-left: 20px;
    }
    .q-table {
      max-width: 600px;
      margin-top: 20px;
    }
    .firstColumnAll {
      width: 320px;
    }
    .secondColumnAll {
      width: 71px;
    }
    .thirdColumnAll {
      width: 128px;
    }
    .fourthColumnAll {
      width: 81px;
    }
    .q-table thead tr,
    .q-table tbody td {
      height: 22px;
      text-align: center;
    }
    .q-table tbody .name {
      text-align: left;
    }
    .dateFor {
      width: 600px;
      text-align: center;
      font-family: Montserrat;
      font-style: normal;
      font-weight: bold;
      font-size: 16px;
      color: #0C4CBC;
    }
    .q-table th, .q-table td {
      padding: 0px 5px;
    }
    .firstColumnUser {
      width: 83px;
    }
    .secondColumnUser {
      width: 353px;
    }
    .thirdColumnUser {
      width: 163px;
    }
    .date {
      font-style: normal;
      font-weight: bold;
      font-size: 16px;
      color: #0C4CBC;
      float: left;
    }
    .datetime {
      float: left;
      margin-left: 73px;
      background: #FFFFFF;
      border: 1px solid #043DA0;
      border-radius: 5px;
      height: 20px;
      font-style: normal;
      font-weight: normal;
      font-size: 12px;
      color: #043DA0;
    }
    .q-datetime-input {
      min-width: 120px;
    }
    .btn_absent {
      float: right;
      margin-top: 25px;
      width: 133px;
      height: 34px;
      background: #3E6DB9;
      border-radius: 30px;
      text-transform: capitalize;
      color: #FFFFFF;
      font-size: 11px;
    }
    .btn {
      max-width: 600px;
    }
    .btn_absent .q-btn-inner {
      font-style: normal;
      font-weight: 500;
      font-size: 11px;
      text-align: center;
      color: #FFFFFF;
    }
    .nameUser {
      margin-top: 8px;
    }

</style>
