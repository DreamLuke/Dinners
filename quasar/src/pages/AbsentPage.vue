<template>
  <q-page padding>
    <form id="absent-form" @submit.prevent="submitForm">
      <div>
        <div style="overflow: hidden">
          <p class="date">Выберите дату:</p>
          <p class="rangeText" v-show="!visible">с</p>
          <q-datetime class="datetime"
                      v-model="date"
                      format="DD.MM.YYYY"
                      :min="new Date()"
          />
          <p class="rangeText" v-show="!visible">по</p>
          <q-datetime :min="date" format="DD.MM.YYYY" v-show="!visible" class="datetime"  v-model="dateSecondInRange"/>
        </div>
        <p class="range" @click="visible=!visible">{{visible?'Укажите диапазон дат':'Скрыть диапазон дат'}}</p>
      </div>
      <div style="overflow: hidden;">
        <p class="date">Укажите тип причины</p>
        <q-select class="datetime"
                  v-model="reason_type"
                  :options="options"
        />
      </div>
      <div>
        <div>
          <textarea :class="classObject" v-model="text" placeholder="Введите причину отсутствия..."></textarea>
          <div v-for="items in validationErrors" v-if="validationErrors.text != ''">
            <div v-for="item in items">
              <span style="color: #ff0000;">{{ item }}</span><br>
            </div>
          </div>
        </div>
      </div>
      <div style="overflow: hidden;" class="btn">
        <q-btn @click="submitForm" class="btn_absent shadow-0" label="Отправить" />
      </div>
    </form>
    <ul class="absent_table">
      <li class="thead">
        <span>Дата</span>
        <span>Тип причины</span>
        <span>Причина</span>
      </li>
      <li>
        <ul class="tbody">
          <li class="tr" v-for="item in absents">
            <span v-if="item.to != null">{{ getNormalDate(item.from) }} - {{ getNormalDate(item.to) }}</span>
            <span v-if="item.to == null">{{ getNormalDate(item.from) }}</span>
            <span>{{ item.reason.name }}</span>
            <span>{{ item.massage }}</span>
          </li>
        </ul>
      </li>
    </ul>
    <notify ref="showNotify"/>
  </q-page>
</template>

<script>
  import notify from '../components/notification';
  import moment from 'moment'
  import { date } from 'quasar'
  export default {
    name: 'absent-info-component',
    components: {notify},
    data () {
      return {
        classObject: {
          'class': true
        },
        date: new Date(),
        dateSecondInRange: '',
        absents: [],
        reason: '',
        visible: true,
        lazy: [],
        reason_type: 1,
        error: true,
        warning: false,
        text: '',
        options: [],
        errors: '',
        validationErrors: '',
      }
    },
    mounted() {
      this.getReasons();
      this.getAbsentInfo();
    },
    methods: {
      submitForm() {
        this.$axios.post('/absent-info', {
          date: this.date,
          dateSecondInRange: this.dateSecondInRange,
          reason_type: this.reason_type,
          text: this.text
        }).then(response => {
          if (response.data == 'repeat') {
            this.$refs.showNotify.showNotify('Вы не можете добавить еще одну причину на выбранную дату!');
          } else {
            this.date = new Date();
            this.dateSecondInRange = '';
            this.reason_type = 1;
            this.text = '';
            this.getAbsentInfo();
          }
        })
        .catch((error) => {
          if (error.response.status == 422){
            this.validationErrors = error.response.data.errors;
        }
      })
    },
      getNormalDate : function (date) {
        return moment(date, 'YYYY-MM-DD').format('DD-MM-YYYY');
      },
      getAbsentInfo: function () {
        this.$axios.get('/get-absent-info')
          .then((response) => {
            this.data = response.data;
            this.absents = response.data.absents;
            this.reason = response.data.reason;
          })
          .catch((err) => {
            console.log(err)
          })
      },
      getReasons: function () {
        this.$axios.get('/get-reasons')
          .then((response) => {
            this.data = response.data;

            for (let i = 0; i < response.data.length; i++) {
              this.options.push(
                      {label: response.data[i]['name'],
                      value: response.data[i]['id']}
                      )
            }
          })
          .catch((err) => {
            console.log(err)
          })
      },
    },
  }
</script>

<style>
  .class {
    border: 3px solid red;
  }
  td .message {
    max-width: 300px;
  }
  #absent-form .date {
    font-style: normal;
    font-weight: bold;
    font-size: 16px;
    color: #0C4CBC;
    float: left;
  }
  #absent-form .datetime {
    float: left;
    margin-left: 20px;
    background: #FFFFFF;
    border: 1px solid #043DA0;
    border-radius: 5px;
    /*max-width: 500px;*/
    height: 20px;
    font-style: normal;
    font-weight: normal;
    font-size: 12px;
    color: #043DA0;
  }
  #absent-form .range {
    font-style: normal;
    font-weight: 500;
    font-size: 12px;
    line-height: 29px;
    color: #043DA0;
    margin-top: -20px;
    cursor: pointer;
    width: 140px;
  }
  #absent-form .q-input-target {
    margin-left: 10px;
  }
  .absent_table {
    margin-top: 37px;
    width: auto;
    max-width: 670px;

    font-style: normal;
    font-weight: normal;
    font-size: 13px;
  }

  .absent_table .thead {
    display: flex;
    justify-content: space-around;
    align-items: center;
    border-bottom: 1px solid #E7E7E7;
    color: #A6A6A6;
  }
  .absent_table .thead span {
    display: flex;
    width: 100%;
    text-align: center;
    justify-content: center;
    align-items: center;
    padding: 10px 0;
  }
  .absent_table .thead span:nth-child(1) {
    width: 110%;
  }
  .absent_table .thead span:nth-child(2) {
    width: 100%;
    padding-left: 10px;
  }
  .absent_table .thead span:nth-child(3) {
    width: 130%;
  }
  .absent_table .tbody {
    max-height: 400px;
    overflow-y: scroll;
  }
  .absent_table .tbody .tr {
    display: flex;
    justify-content: space-around;
    height: 55px;
    transition: 0.15s;
  }
  .absent_table .tbody .tr span {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    color: #043DA0;
    border-bottom: 1px solid #E7E7E7;
  }
  .absent_table .tbody .tr:hover {
    background-color: #eeeeee;
  }

  #absent-form .date {
    font-style: normal;
    font-weight: bold;
    font-size: 16px;
    color: #0C4CBC;
    float: left;
  }
  #absent-form .datetime {
    float: left;
    margin-left: 20px;
    background: #FFFFFF;
    border: 1px solid #043DA0;
    border-radius: 5px;
    /*max-width: 500px;*/
    height: 20px;
    font-style: normal;
    font-weight: normal;
    font-size: 12px;
    color: #043DA0;
  }
  #absent-form .range {
    font-style: normal;
    font-weight: 500;
    font-size: 12px;
    line-height: 29px;/* identical to box height, or 242% */
    color: #043DA0;
    margin-top: -20px;
    cursor: pointer;
  }
  #absent-form .rangeText {
    float: left;
    margin-left: 20px;
    font-style: normal;
    font-weight: bold;
    font-size: 16px;
    color: #0C4CBC;
  }
  .q-popover .q-item-section {
    color: #1b1e21;
  }
  #absent-form textarea {
    width: 671px;
    height: 112px;
    background: #FFFFFF;
    border: 1px solid #043DA0;
    box-sizing: border-box;
    box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
    resize: none;
    padding: 5px 10px;
  }
  #absent-form .btn {
    width: 671px;
  }
  textarea::placeholder {
    color: #173156;
  }
  .btn_absent {
    float: right;
    margin-top: 25px;
    width: 133px;
    height: 34px;
    background: #3E6DB9;
    border-radius: 30px;
    text-transform: capitalize;
  }
  .btn_absent .q-btn-inner {
    font-style: normal;
    font-weight: 500;
    font-size: 11px;
    text-align: center;
    color: #FFFFFF;
  }
</style>
